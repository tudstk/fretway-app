namespace Fretway.Domain.Enums;

/// <summary>
/// Type of in-app notification (e.g. reminder, achievement).
/// </summary>
public enum NotificationType
{
    Reminder = 0,
    Achievement = 1,
    Streak = 2,
    GoalProgress = 3,
    System = 4
}
