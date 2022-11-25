package com.ssafy.member.service;

import com.ssafy.member.model.MemberDTO;

public interface MemberService {
	MemberDTO login(MemberDTO memberDTO) throws Exception;
	MemberDTO getUserInfo(String id) throws Exception;
	int join(MemberDTO memberDTO) throws Exception;
	int editInfo(MemberDTO memberDTO) throws Exception;
	int deleteInfo(String id) throws Exception;
	public void saveRefreshToken(String id, String refreshToken) throws Exception;
	public Object getRefreshToken(String id) throws Exception;
	public void deleRefreshToken(String id) throws Exception;
	String checkId(String id) throws Exception;
}
