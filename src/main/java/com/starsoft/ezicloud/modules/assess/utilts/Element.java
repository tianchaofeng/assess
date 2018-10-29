package com.starsoft.ezicloud.modules.assess.utilts;

/**
 * 数据属性
 * k  属性key值
 * v  属性值
 * m  属性最大值
 */
public class Element {

	private String K;
	private double v;
	private double m;
	private double v1;
	
	public String getK() {
		return K;
	}
	public void setK(String k) {
		K = k;
	}
	public double getV() {
		return v;
	}
	public void setV(double v) {
		this.v = v;
	}
	public double getM() {
		return m;
	}
	public void setM(double m) {
		this.m = m;
	}
	public double getV1() {
		return v1;
	}
	public void setV1(double v1) {
		this.v1 = v1;
	}
	
}
