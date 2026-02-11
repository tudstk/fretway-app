namespace Fretway.Domain.Entities;

/// <summary>
/// A step within a goal. Can have optional video proof and target date.
/// </summary>
public class Milestone
{
    public Guid Id { get; set; }
    public Guid GoalId { get; set; }
    public string Title { get; set; } = string.Empty;
    public string? Description { get; set; }
    public bool IsCompleted { get; set; }
    public DateTime? CompletedAt { get; set; }
    public DateTime? TargetDate { get; set; }
    public string? VideoUrl { get; set; }
    public string? VideoThumbnailUrl { get; set; }
    public int Order { get; set; }

    public Goal Goal { get; set; } = null!;
}
