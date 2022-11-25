package com.ssafy.member.controller;

import java.util.HashMap;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.member.model.MemberDTO;
import com.ssafy.member.service.MemberServiceImpl;
import com.ssafy.wh.service.JwtServiceImpl;

import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

@RestController
@RequestMapping("/user")
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";

	@Autowired
	private JwtServiceImpl jwtService;

	@Autowired
	MemberServiceImpl service;

	@ApiOperation(value = "로그인", notes = "Access-token과 로그인 결과 메세지를 반환한다.", response = Map.class)
	@PostMapping("/login")
	public ResponseEntity<Map<String, Object>> login(
			@RequestBody @ApiParam(value = "로그인 시 필요한 회원정보(아이디, 비밀번호).", required = true) MemberDTO memberDto) {
		logger.info("login - 호출");
		
		logger.debug("memberDto info : {}", memberDto);

		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = null;
		try {
			MemberDTO loginUser = service.login(memberDto);
			if (loginUser != null) {
				logger.debug("loginUser info : {}", loginUser);
				String accessToken = jwtService.createAccessToken("id", loginUser.getId());// key, data
				String refreshToken = jwtService.createRefreshToken("id", loginUser.getId());// key, data
				logger.debug(loginUser.getId());
				logger.debug(loginUser.getPw());
				logger.debug(loginUser.getComment());
				
				service.saveRefreshToken(memberDto.getId(), refreshToken);
				logger.debug("로그인 accessToken 정보 : {}", accessToken);
				logger.debug("로그인 refreshToken 정보 : {}", refreshToken);
				resultMap.put("access-token", accessToken);
				resultMap.put("refresh-token", refreshToken);
				resultMap.put("message", SUCCESS);
				status = HttpStatus.ACCEPTED;
			} else {
				resultMap.put("message", FAIL);
				status = HttpStatus.ACCEPTED;
			}
		} catch (Exception e) {
			logger.error("로그인 실패 : {}", e);
			resultMap.put("message", e.getMessage());
			status = HttpStatus.INTERNAL_SERVER_ERROR;
			
		}
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}
	
	@ApiOperation(value = "로그아웃", notes = "회원 정보를 담은 Token을 제거한다.", response = Map.class)
	@GetMapping("/logout/{userid}")
	public ResponseEntity<?> removeToken(@PathVariable("userid") String userid) {
		logger.debug("토큰삭제!!!!!!!!!!!!!!!!");
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = HttpStatus.ACCEPTED;
		try {
			service.deleRefreshToken(userid);
			resultMap.put("message", SUCCESS);
			status = HttpStatus.ACCEPTED;
		} catch (Exception e) {
			logger.error("로그아웃 실패 : {}", e);
			resultMap.put("message", e.getMessage());
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		}
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}

	@ApiOperation(value = "회원가입", notes = "회원가입 성공유무에 따라 success, fail 결과 메세지를 반환한다.", response = String.class)
	@PostMapping("/join")
	public ResponseEntity<String> join(@RequestBody @ApiParam(value = "회원가입 정보.", required = true) MemberDTO memberDto)
			throws Exception {
		logger.info("join - 호출");
		
		System.out.println(memberDto.toString());

		if (service.join(memberDto) != 0) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		} else
			return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}
	
	@ApiOperation(value = "id체크", notes = "id체크 유무에 따라 success, fail 결과 메세지를 반환한다.", response = String.class)
	@GetMapping("/checkId/{id}")
	public ResponseEntity<String> checkId(@PathVariable("id") String id)
			throws Exception {
		logger.info("checkId - 호출");

		if (service.checkId(id)==null||!service.checkId(id).equals(id)) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		} else
			return new ResponseEntity<String>(FAIL, HttpStatus.OK);
	}
	
	@ApiOperation(value = "회원정보", notes = "id에 해당하는 회원정보를 반환", response = MemberDTO.class)
	@GetMapping("/userInfo/{id}")
	public ResponseEntity<?> getUserInfo(@PathVariable("id") String id) throws Exception {
		MemberDTO memberDto = service.getUserInfo(id);
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(memberDto !=null) {
			map.put("userInfo", memberDto);
			map.put("message",SUCCESS);
		}
		
		logger.info("getUserInfo - 호출");
		logger.info(id);
		return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
	}
	
	@ApiOperation(value = "회원정보 수정", notes = "수정할 회원 정보를 입력한다. 그리고 DB수정 성공여부에 따라 'success' 또는 'fail' 문자열을 반환한다.", response = String.class)
	@PutMapping("/modify")
	public ResponseEntity<String> modifyUserInfo(
			@RequestBody @ApiParam(value = "수정할 회원정보.", required = true) MemberDTO memberDto) throws Exception {
		logger.info("modifyUserInfo - 호출 {}", memberDto);

		if (service.editInfo(memberDto) != 0) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.OK);
	}

	@ApiOperation(value = "회원정보 삭제", notes = "id에 해당하는 회원정보를 삭제한다. 그리고 DB삭제 성공여부에 따라 'success' 또는 'fail' 문자열을 반환한다.", response = String.class)
	@DeleteMapping("/delete/{id}")
	public ResponseEntity<String> deleteUser(
			@PathVariable("id") @ApiParam(value = "살제할 회원 아이디.", required = true) String id)
			throws Exception {
		logger.info("deleteUser - 호출");
		if (service.deleteInfo(id) != 0) {
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}

	private ResponseEntity<String> exceptionHandling(Exception e) {
		e.printStackTrace();
		return new ResponseEntity<String>("Error : " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
