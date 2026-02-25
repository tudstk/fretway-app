namespace Fretway.Domain.Entities;

/// <summary>
/// Join entity: user has unlocked a badge at a given time.
/// </summary>
public class UserBadge
{
    public string UserId { get; set; } = string.Empty;
    public Guid BadgeId { get; set; }
    public DateTime UnlockedAt { get; set; }

    public User User { get; set; } = null!;
    public Badge Badge { get; set; } = null!;
}
