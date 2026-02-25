namespace Fretway.Domain.Entities;

/// <summary>
/// A named set of exercises the user practices together. Supports soft delete and concurrency.
/// </summary>
public class PracticeSet
{
    public Guid Id { get; set; }
    public string UserId { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public int EstimatedDurationMinutes { get; set; }
    public DateTime? LastPracticedAt { get; set; }
    public bool IsDeleted { get; set; }
    public DateTime? DeletedAt { get; set; }
    public byte[]? RowVersion { get; set; }

    public User User { get; set; } = null!;
    public List<PracticeSetExercise> PracticeSetExercises { get; set; } = [];
    public ICollection<PracticeSession> PracticeSessions { get; set; } = [];
}
