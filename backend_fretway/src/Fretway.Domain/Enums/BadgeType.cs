namespace Fretway.Domain.Enums;

/// <summary>
/// Type of achievement badge. Used for gamification and display.
/// </summary>
public enum BadgeType
{
    FirstStep = 0,       // Complete first milestone
    OnARoll = 1,         // 3-day streak
    WeekWarrior = 2,     // 7-day streak
    Dedicated = 3,       // 30-day streak
    GoalCrusher = 4,     // Complete first goal
    Centurion = 5,       // 100 hours practiced
    SpeedDemon = 6       // BPM milestone over 160
}
