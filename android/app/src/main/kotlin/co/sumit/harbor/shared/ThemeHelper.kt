package co.sumit.harbor.shared

import android.graphics.Color

object ThemeHelper {
  fun themeColor(mode: String?): Int? = when (mode) {
    "oled" -> Color.BLACK
    "dark" -> Color.parseColor("#131313")
    "light" -> Color.parseColor("#F9F9F9")
    else -> null
  }
}
