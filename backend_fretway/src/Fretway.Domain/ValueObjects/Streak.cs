namespace Fretway.Domain.ValueObjects;

/// <summary>
/// Value object representing a user's practice streak (current and best).
/// Used for display and badge evaluation; persisted via Streak entity.
/// </summary>
public record StreakValue(int CurrentStreak, int BestStreak, DateOnly? LastPracticedDate);
