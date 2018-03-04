package com.tx.util;

import org.apache.poi.ss.usermodel.Cell;

public  class IntegerUtil {
	
	public static int getInt(Cell cell){
		int num = 0;
		if(cell!=null&&!"".equals(cell.toString())){
			num = (int)Double.parseDouble(cell.toString());
		}
		return num;
	}
	
	public static String getString(Cell cell){
		String str = null;
		if(cell!=null){
			str = cell.toString();
		}
		return str;
		
	}
}
