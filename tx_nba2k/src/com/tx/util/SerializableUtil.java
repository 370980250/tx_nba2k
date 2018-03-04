package com.tx.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;


public class SerializableUtil{
	

	
	public static  Object unserObj(byte[] byt){
		ObjectInputStream ois = null;
		ByteArrayInputStream bis = null;
		Object obj = null;
		bis = new ByteArrayInputStream(byt);
		try {
			ois = new ObjectInputStream(bis);
			obj = ois.readObject();
		} catch (IOException | ClassNotFoundException e) {
			e.printStackTrace();
		}finally{
			if(bis!=null){
				try {
					bis.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if(ois!=null){
				try {
					ois.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return obj;
	}
	
	public static  byte[] serObj(Object obj){
		ObjectOutputStream oos = null;
		ByteArrayOutputStream bai =null;
		byte[] byt = null;
		try {
			bai = new ByteArrayOutputStream();
			oos = new ObjectOutputStream(bai);
			oos.writeObject(obj);
			byt = bai.toByteArray();
			bai.flush();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			if(bai!=null){
				try {
					bai.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if(oos!=null){
				try {
					oos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return byt;
	}
}
