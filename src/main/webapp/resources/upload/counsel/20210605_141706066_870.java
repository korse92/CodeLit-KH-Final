package com.kh.java.lambda;

import java.util.Date;

/**
 * 함수형 프로그래밍
 * - 객체지향의 메소드
 * 
 * - 함수 호출시 암시적인 입력값/결과값의 사용을 자제하고,
 *   명시적인 입력값/결과값을 사용하려는 프로그래밍
 * - 함수가 일급값 : 인자로 전달, 리턴값으로 함수를 처리
 *
 */
public class LambdaTest1 {
	
	private long num = new Date().getTime();
	
	/**
	 * 함수호출시 
	 * 1. 명시적/암시적 입력값
	 * 2. 명시적/암시적 결과값
	 * 
	 * @param n
	 * @return
	 */
	public long calc(int n){ 
		return num + n;
	}
	
	public static void main(String[] args) {
		long result = new LambdaTest1().calc(3);
		System.out.println(result);
	}

}
