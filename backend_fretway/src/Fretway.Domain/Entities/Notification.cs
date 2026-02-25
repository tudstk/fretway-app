using Fretway.Domain.Enums;

namespace Fretway.Domain.Entities;

/// <summary>
/// In-app notification for a user (reminders, achievements, etc.).
/// </summary>
public class Notification
{
    public Guid Id { get; set; }
    public string UserId { get; set; } = string.Empty;
    public NotificationType Type { get; set; }
    public string Title { get; set; } = string.Empty;
    public string Message { get; set; } = string.Empty;
    public bool IsRead { get; set; }
    public DateTime CreatedAt { get; set; }

    public User User { get; set; } = null!;
}
