namespace Fretway.Application.Common;

/// <summary>
/// Result type for operations that can fail with a known error.
/// Avoids throwing exceptions for expected outcomes (e.g. validation, not found).
/// </summary>
public class Result<TValue>
{
    public TValue? Value { get; }
    public Error? Error { get; }
    public bool IsSuccess => Error is null;

    private Result(TValue value)
    {
        Value = value;
        Error = null;
    }

    private Result(Error error)
    {
        Value = default;
        Error = error;
    }

    public static implicit operator Result<TValue>(TValue value) => new(value);
    public static implicit operator Result<TValue>(Error error) => new(error);

    /// <summary>Creates a failed result. Used by ValidationBehavior to return validation errors.</summary>
    public static Result<TValue> Failure(Error error) => new(error);
}

/// <summary>
/// Immutable error with code, description, and HTTP status for API mapping.
/// </summary>
/// <param name="Code">Machine-readable code (e.g. Goal.NotFound).</param>
/// <param name="Description">Human-readable message.</param>
/// <param name="HttpStatusCode">HTTP status to return (default 400).</param>
public record Error(string Code, string Description, int HttpStatusCode = 400)
{
    public static readonly Error None = new(string.Empty, string.Empty, 0);
}
