package com.ssafy.qna.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.qna.model.QnaDTO;
import com.ssafy.qna.service.QnaService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

@RestController
@RequestMapping("/qna")
@Api("QnA 컨트롤러  API V1")
public class QnaController {

	private static final Logger logger = LoggerFactory.getLogger(QnaController.class);
	
	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";

	private QnaService service;

	@Autowired
	public QnaController(QnaService service) {
		super();
		this.service = service;
	}

	@ApiOperation(value = "qna 글목록", notes = "모든 qna 정보를 반환한다.", response = List.class)
	@GetMapping("")
	public ResponseEntity<?> getList() throws Exception {

		System.out.println("qna list hi");

		return new ResponseEntity<List<QnaDTO>>(service.getList(), HttpStatus.OK);
	}

	@ApiOperation(value = "qna 상세", notes = "qna 상세 정보를 반환한다.", response = List.class)
	@GetMapping("/{qnaNo}")
	public ResponseEntity<?> qnaInfo(@PathVariable("qnaNo") int qnaNo) throws Exception {

		System.out.println("info hi");

//		service.updateHit(qnaNo);
		return new ResponseEntity<QnaDTO>(service.getQna(qnaNo), HttpStatus.OK);
	}
	
	@ApiOperation(value = "qna 답변 상태", notes = "qna 답변 상태 정보를 반환한다.", response = String.class)
	@GetMapping("/state/{qnaNo}")
	public ResponseEntity<?> qnaState(@PathVariable("qnaNo") int qnaNo) throws Exception {

		logger.info("qnaState - 호출");
		
		System.out.println(service.state(qnaNo));
		
		if(service.state(qnaNo)==0)
			return new ResponseEntity<String>("flase", HttpStatus.OK);
		return new ResponseEntity<String>("true", HttpStatus.OK);
	}

	@ApiOperation(value = "qna 글작성", notes = "새로운 qna 정보를 입력한다. 그리고 DB입력 성공여부에 따라 'success' 또는 'fail' 문자열을 반환한다.", response = String.class)
	@PostMapping("/write")
	public ResponseEntity<String> writeQna(@RequestBody @ApiParam(value = "qna 정보.", required = true) QnaDTO qnaDto)
			throws Exception {
		logger.info("wirteQna - 호출");

		if (service.writeQna(qnaDto) != 0) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		} else
			return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}
	
	@ApiOperation(value = "qna 글수정", notes = "수정할 qna 정보를 입력한다. 그리고 DB수정 성공여부에 따라 'success' 또는 'fail' 문자열을 반환한다.", response = String.class)
	@PutMapping("/{qnaNo}/modify")
	public ResponseEntity<String> modifyQna(@RequestBody @ApiParam(value = "수정할 글정보.", required = true) QnaDTO qnaDto) throws Exception {
		logger.info("modifyQna - 호출 {}", qnaDto);
		
		if (service.modifyQna(qnaDto)!=0) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.OK);
	}
	
	@ApiOperation(value = "qna 글삭제", notes = "글번호에 해당하는 qna 정보를 삭제한다. 그리고 DB삭제 성공여부에 따라 'success' 또는 'fail' 문자열을 반환한다.", response = String.class)
	@DeleteMapping("/{qnaNo}/delete")
	public ResponseEntity<String> deleteQna(@PathVariable("qnaNo") @ApiParam(value = "살제할 글의 글번호.", required = true) int qnaNo) throws Exception {
		logger.info("deleteQna - 호출");
		if (service.deleteQna(qnaNo)!=0) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}
	
	@ApiOperation(value = "qna 답변 작성", notes = "새로운 qna 답변 정보를 입력한다. 그리고 DB입력 성공여부에 따라 'success' 또는 'fail' 문자열을 반환한다.", response = String.class)
	@PostMapping("/writeAnswer")
	public ResponseEntity<String> writeAnswer(@RequestBody @ApiParam(value = "qna 답변 정보.", required = true) QnaDTO qnaDto)
			throws Exception {
		logger.info("writeQnaAnswer - 호출");

		if (service.writeAnswer(qnaDto) != 0) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		} else
			return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}

}
