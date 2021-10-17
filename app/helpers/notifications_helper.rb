module NotificationsHelper
  def notification_form(notification)
    visiter = notification.visiter
    visited = notification.visited
    case notification.action
    when "follow" then
      tag.a(notification.visiter.name, href: user_path(visiter), style: "font-weight: bold;") + "があなたのことをフォローしました"
    when "like" then
      tag.a(notification.visiter.name, href: user_path(visiter), style: "font-weight: bold;") + "が" + tag.a('あなたの商品', href: item_path(notification.item_id), style: "font-weight: bold;") + "にいいねしました"
    when "comment" then
      if notification.item.user_id == visited.id
        tag.a(visiter.name, href: user_path(visiter), style: "font-weight: bold;") + "が" + tag.a('あなたの商品', href: item_path(notification.item_id), style: "font-weight: bold;") + "にコメントしました"
      else
        tag.a(visiter.name, href: user_path(visiter), style: "font-weight: bold;") + "が" + tag.a('あなたの返信', href: item_path(notification.item_id), style: "font-weight: bold;") + "にコメントしました"
      end
    when "purchase" then
      tag.a(notification.visiter.name, href: user_path(visiter), style: "font-weight: bold;") + "が" + tag.a('あなたの商品', href: item_path(notification.item_id), style: "font-weight: bold;") + "を購入しました!"
    end
  end
end
