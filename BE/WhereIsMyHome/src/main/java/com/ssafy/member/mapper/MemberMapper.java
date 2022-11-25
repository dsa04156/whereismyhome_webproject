package com.ssafy.member.mapper;

import java.sql.SQLException;
import java.util.Map;

import com.ssafy.member.model.MemberDTO;

public interface MemberMapper {
	MemberDTO login(MemberDTO memberDTO);
	MemberDTO getUserInfo(String id);
	int join(MemberDTO memberDTO) throws SQLException;
	int editInfo(MemberDTO memberDTO) throws SQLException;
	int deleteInfo(String id) throws SQLException;
	String checkId(String id) throws SQLException;
	public void saveRefreshToken(Map<String, String> map) throws SQLException;
	public Object getRefreshToken(String id) throws SQLException;
	public void deleteRefreshToken(Map<String, String> map) throws SQLException;
}
