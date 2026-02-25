using Fretway.Domain.Enums;

namespace Fretway.Domain.Entities;

/// <summary>
/// An exercise (predefined or user-created). Predefined exercises cannot be deleted.
/// </summary>
public class Exercise
{
    public Guid Id { get; set; }
    public string Title { get; set; } = string.Empty;
    public string? Description { get; set; }
    public string? VideoUrl { get; set; }
    public string? FretboardDiagramUrl { get; set; }
    public ExerciseDifficulty Difficulty { get; set; }
    public bool IsPredefined { get; set; }
    public string? CreatedByUserId { get; set; }
    public int? BpmSuggestion { get; set; }

    public User? CreatedByUser { get; set; }
    public ICollection<PracticeSetExercise> PracticeSetExercises { get; set; } = [];
}
