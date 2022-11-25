package com.ssafy.qna.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.qna.mapper.QnaMapper;
import com.ssafy.qna.model.QnaDTO;

@Service
public class QnaServiceImpl implements QnaService {
	
	private QnaMapper mapper;
	
	@Autowired
	public QnaServiceImpl(QnaMapper mapper) {
		super();
		this.mapper = mapper;
	}

	@Override
	public List<QnaDTO> getList() throws Exception {
		return mapper.getList();
	}

	@Override
	public QnaDTO getQna(int qnaNo) throws Exception {
		return mapper.getQna(qnaNo);
	}

	@Override
	public int writeQna(QnaDTO qnaDto) throws Exception {
		return mapper.writeQna(qnaDto);
	}

	@Override
	public int modifyQna(QnaDTO qnaDto) throws Exception {
		return mapper.modifyQna(qnaDto);
	}

	@Override
	public int deleteQna(int qnaNo) throws Exception {
		return mapper.deleteQna(qnaNo);
	}

	@Override
	public int updateHit(int qnaNo) throws Exception {
		return mapper.updateHit(qnaNo);
	}

	@Override
	public int writeAnswer(QnaDTO qnaDto) throws Exception {
		return mapper.writeAnswer(qnaDto);
	}

	@Override
	public int state(int qnaNo) throws Exception {
		int state = mapper.state(qnaNo);
		return state == 0 ? 0 : 1;
	}


}
