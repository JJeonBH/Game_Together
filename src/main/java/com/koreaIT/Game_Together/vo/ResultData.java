package com.koreaIT.Game_Together.vo;

import lombok.Data;

@Data
public class ResultData<DT> {
	
	private String resultCode;
	private String msg;
	private String data1Name;
	private DT data1;
	private String data2Name;
	private Object data2;
	
	public static <DT> ResultData<DT> resultFrom(String resultCode, String msg) {
		
		return resultFrom(resultCode, msg, null, null);
		
	}
	
	public static <DT> ResultData<DT> resultFrom(String resultCode, String msg, String data1Name, DT data1) {
		
		ResultData<DT> rd = new ResultData<>();
		
		rd.resultCode = resultCode;
		rd.msg = msg;
		rd.data1Name = data1Name;
		rd.data1 = data1;
		
		return rd;
		
	}
	
	public boolean isSuccess() {
		
		return this.resultCode.startsWith("S");
		
	}
	
	public boolean isFail() {
		
		return this.resultCode.startsWith("F");
		
	}
	
	public void setData2(String data2Name, Object data2) {
		
		this.data2Name = data2Name;
		this.data2 = data2;
		
	}
	
}