package com.hyundai.domain;

import lombok.Data;

@Data
public class PaymentMethodVO {
	private String pmcode;
	private String pmcompany;
	private int pmmethod;
}
