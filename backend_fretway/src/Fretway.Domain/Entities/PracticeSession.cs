namespace Fretway.Domain.Entities;

/// <summary>
/// A single practice session (started from a practice set). Used for history and XP.
/// </summary>
public class PracticeSession
{
    public Guid Id { get; set; }
    public string UserId { get; set; } = string.Empty;
    public Guid PracticeSetId { get; set; }
    public DateTime StartedAt { get; set; }
    public DateTime? EndedAt { get; set; }
    public int? ActualMinutesPracticed { get; set; }
    public string? Notes { get; set; }

    public User User { get; set; } = null!;
    public PracticeSet PracticeSet { get; set; } = null!;
}
