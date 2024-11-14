package com.example.countdown

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin

class CountdownWidgetProvider : AppWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.countdown_widget_layout).apply {
                val widgetData = HomeWidgetPlugin.getData(context)
                val daysRemaining = widgetData.getInt("days_remaining", 0)
                setTextViewText(R.id.days_text, "$daysRemaining\nDAYS")
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}