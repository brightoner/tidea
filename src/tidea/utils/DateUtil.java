package tidea.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class DateUtil {
	public static String today(){
		SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yy/MM/dd", Locale.KOREA );
		Date currentTime = new Date ();
		String mTime = mSimpleDateFormat.format ( currentTime );

		return mTime;
	}
}
