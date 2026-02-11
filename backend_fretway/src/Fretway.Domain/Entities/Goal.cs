using Fretway.Domain.Enums;

namespace Fretway.Domain.Entities;

/// <summary>
/// A learning goal with milestones. Progress is 0-100, recalculated from completed milestones.
/// </summary>
public class Goal
{
    public Guid Id { get; set; }
    public string UserId { get; set; } = string.Empty;
    public string Title { get; set; } = string.Empty;
    public string? Description { get; set; }
    public DateTime? TargetDate { get; set; }
    public GoalCategory Category { get; set; }
    public int Progress { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
    public bool IsDeleted { get; set; }
    public DateTime? DeletedAt { get; set; }
    public byte[]? RowVersion { get; set; }

    public User User { get; set; } = null!;
    public List<Milestone> Milestones { get; set; } = [];

    /// <summary>
    /// Recalculates progress from completed milestones. Call after milestone completion changes.
    /// </summary>
    public void RecalculateProgress()
    {
        if (Milestones.Count == 0)
        {
            Progress = 0;
            return;
        }

        int completed = Milestones.Count(m => m.IsCompleted);
        Progress = (int)Math.Round((double)completed / Milestones.Count * 100);
    }
}
