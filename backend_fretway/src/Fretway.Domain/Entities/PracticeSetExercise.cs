namespace Fretway.Domain.Entities;

/// <summary>
/// Join entity linking a practice set to an exercise with an order for sequencing.
/// </summary>
public class PracticeSetExercise
{
    public Guid PracticeSetId { get; set; }
    public Guid ExerciseId { get; set; }
    public int Order { get; set; }

    public PracticeSet PracticeSet { get; set; } = null!;
    public Exercise Exercise { get; set; } = null!;
}
