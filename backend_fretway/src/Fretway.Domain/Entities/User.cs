namespace Fretway.Domain.Entities;

/// <summary>
/// User of the app. Owns goals, practice sets, sessions, and achievements.
/// </summary>
public class User
{
    public string Id { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string PasswordHash { get; set; } = string.Empty;
    public string? ProfilePictureUrl { get; set; }
    public int Level { get; set; }
    public int TotalXp { get; set; }
    public DateTime CreatedAt { get; set; }

    public ICollection<Goal> Goals { get; set; } = [];
    public ICollection<PracticeSet> PracticeSets { get; set; } = [];
    public ICollection<PracticeSession> PracticeSessions { get; set; } = [];
    public ICollection<UserBadge> UserBadges { get; set; } = [];
    public Streak? Streak { get; set; }
    public ICollection<Notification> Notifications { get; set; } = [];
    public ICollection<Exercise> CustomExercises { get; set; } = [];
}
