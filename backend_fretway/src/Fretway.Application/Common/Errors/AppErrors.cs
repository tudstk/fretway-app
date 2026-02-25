namespace Fretway.Application.Common.Errors;

/// <summary>
/// Centralized application errors. No magic strings in handlers.
/// Nested classes group by aggregate (User, Goal, etc.).
/// </summary>
public static class AppErrors
{
    public static class User
    {
        public static readonly Error NotFound = new("User.NotFound", "User not found.", 404);
        public static readonly Error EmailTaken = new("User.EmailTaken", "This email is already registered.", 409);
        public static readonly Error InvalidCredentials = new("User.InvalidCredentials", "Email or password is incorrect.", 401);
    }

    public static class Goal
    {
        public static readonly Error NotFound = new("Goal.NotFound", "Goal not found.", 404);
        public static readonly Error NotOwnedByUser = new("Goal.Forbidden", "You don't have access to this goal.", 403);
    }

    public static class Milestone
    {
        public static readonly Error NotFound = new("Milestone.NotFound", "Milestone not found.", 404);
        public static readonly Error AlreadyCompleted = new("Milestone.AlreadyCompleted", "This milestone is already completed.", 409);
    }

    public static class PracticeSet
    {
        public static readonly Error NotFound = new("PracticeSet.NotFound", "Practice set not found.", 404);
        public static readonly Error NotOwnedByUser = new("PracticeSet.Forbidden", "You don't have access to this practice set.", 403);
    }

    public static class PracticeSession
    {
        public static readonly Error NotFound = new("PracticeSession.NotFound", "Session not found.", 404);
        public static readonly Error AlreadyCompleted = new("PracticeSession.AlreadyCompleted", "This session is already completed.", 409);
        public static readonly Error NotOwnedByUser = new("PracticeSession.Forbidden", "You don't have access to this session.", 403);
    }

    public static class Exercise
    {
        public static readonly Error NotFound = new("Exercise.NotFound", "Exercise not found.", 404);
        public static readonly Error CannotDeletePredefined = new("Exercise.Predefined", "Predefined exercises cannot be deleted.", 403);
    }

    public static class Notification
    {
        public static readonly Error NotFound = new("Notification.NotFound", "Notification not found.", 404);
    }
}
