namespace Fretway.Domain.Entities;

/// <summary>
/// Per-user streak data: current streak, best streak, last practiced date.
/// </summary>
public class Streak
{
    public Guid Id { get; set; }
    public string UserId { get; set; } = string.Empty;
    public int CurrentStreak { get; set; }
    public int BestStreak { get; set; }
    public DateOnly? LastPracticedDate { get; set; }

    public User User { get; set; } = null!;
}
