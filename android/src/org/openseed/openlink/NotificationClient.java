package org.openseed.openlink;

import android.app.Notification;
import android.content.Intent;
import android.content.Context;
import android.app.NotificationChannel;
import android.app.PendingIntent;
import android.os.Handler;
import android.widget.Toast;
import android.os.Message;
import android.app.Notification;
import android.app.NotificationManager;
import android.content.Context;
import android.os.Bundle;
import android.os.Build;
import android.R;
import android.os.Handler;
import android.os.Message;

public class NotificationClient extends org.qtproject.qt5.android.bindings.QtActivity
{
    private static NotificationManager m_notificationManager;
          private static Notification.Builder m_builder;
          private static NotificationClient m_instance;

          public NotificationClient()
          {
              m_instance = this;
          }
   public void onCreate(Bundle savedInstanceState) {
           super.onCreate(savedInstanceState);
               String channelId = "chat";
               String channelName = "OpenLink";
               int importance = NotificationManager.IMPORTANCE_HIGH;
               createNotificationChannel(channelId, channelName, importance);
               channelId = "conversation";
               channelName = "OpenLink";
               importance = NotificationManager.IMPORTANCE_DEFAULT;
               createNotificationChannel(channelId, channelName, importance);

       }


    private void createNotificationChannel(String channelId, String channelName, int importance) {
           NotificationChannel channel = new NotificationChannel(channelId, channelName, importance);
           NotificationManager notificationManager = (NotificationManager)getSystemService(
                   NOTIFICATION_SERVICE);
           notificationManager.createNotificationChannel(channel);
       }


   public static void notify(String s)
  {
      NotificationManager manager = (NotificationManager)

      m_instance.getSystemService(NOTIFICATION_SERVICE);
      Notification notification = new Notification.Builder(m_instance, "subscribe")
              .setContentTitle("OpenLink:")
              .setContentText(s)
              .setWhen(System.currentTimeMillis())
              .setSmallIcon(R.drawable.sym_action_chat)

              .setAutoCancel(true)
              .build();
      manager.notify(1, notification);
 }

}



