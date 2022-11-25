package com.ssafy.qna.service;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.qna.model.QnaDTO;

public interface QnaService {

	List<QnaDTO> getList() throws Exception;
	QnaDTO getQna(int qnaNo) throws Exception;
	int writeQna(QnaDTO qnaDto) throws Exception;
	int modifyQna(QnaDTO qnaDto) throws Exception;
	int deleteQna(int qnaNo) throws Exception;
	int updateHit(int qnaNo) throws Exception;
	int writeAnswer(QnaDTO qnaDto) throws Exception;
	int state(int qnaNo) throws Exception;
}
