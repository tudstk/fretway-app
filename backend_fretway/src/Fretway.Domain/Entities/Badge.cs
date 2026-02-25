using Fretway.Domain.Enums;

namespace Fretway.Domain.Entities;

/// <summary>
/// Definition of an achievement badge. Users unlock via UserBadge.
/// </summary>
public class Badge
{
    public Guid Id { get; set; }
    public BadgeType Type { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public string? IconUrl { get; set; }
    public string? UnlockConditionDescription { get; set; }

    public ICollection<UserBadge> UserBadges { get; set; } = [];
}
