using FluentValidation;
using MediatR;

namespace Fretway.Application.Common.Behaviors;

/// <summary>
/// MediatR pipeline behavior: runs FluentValidation for every request.
/// Returns validation errors as Result before the handler runs.
/// </summary>
internal sealed class ValidationBehavior<TRequest, TResponse> : IPipelineBehavior<TRequest, TResponse>
    where TRequest : IRequest<TResponse>
{
    private readonly IEnumerable<IValidator<TRequest>> _validators;

    public ValidationBehavior(IEnumerable<IValidator<TRequest>> validators)
    {
        _validators = validators;
    }

    public async Task<TResponse> Handle(
        TRequest request,
        RequestHandlerDelegate<TResponse> next,
        CancellationToken cancellationToken)
    {
        if (_validators.Any() == false)
            return await next();

        var context = new ValidationContext<TRequest>(request);
        var results = await Task.WhenAll(
            _validators.Select(v => v.ValidateAsync(context, cancellationToken)));

        var failures = results
            .SelectMany(r => r.Errors)
            .Where(f => f is not null)
            .ToList();

        if (failures.Count == 0)
            return await next();

        Type responseType = typeof(TResponse);
        if (responseType.IsGenericType && responseType.GetGenericTypeDefinition() == typeof(Result<>))
        {
            Error error = new Error(
                "Validation.Error",
                string.Join(" ", failures.Select(f => f.ErrorMessage)),
                400);
            Type valueType = responseType.GetGenericArguments()[0];
            Type resultType = typeof(Result<>).MakeGenericType(valueType);
            var failureMethod = resultType.GetMethod("Failure", [typeof(Error)]);
            if (failureMethod is not null)
            {
                object? failedResult = failureMethod.Invoke(null, [error]);
                if (failedResult is not null)
                    return (TResponse)failedResult;
            }
        }

        return await next();
    }
}
