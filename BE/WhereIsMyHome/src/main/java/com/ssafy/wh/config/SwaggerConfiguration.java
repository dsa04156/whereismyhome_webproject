package com.ssafy.wh.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

//import com.google.common.base.Predicate;
//import com.google.common.base.Predicates;

import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
//import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
//import springfox.documentation.swagger.web.UiConfiguration;
//import springfox.documentation.swagger.web.UiConfigurationBuilder;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@Configuration // 스프링 실행시 설정파일
@EnableSwagger2 // Swagger2를 사용
@SuppressWarnings("unchecked") // warning 제거
public class SwaggerConfiguration {

	// http://localhost:80//swagger-ui.html#/  => 이걸로
	
	// http://localhost:80//swagger-ui/
//	Swagger-UI 2.x 확인
//	http://localhost[:8080]/{your-app-root}/swagger-ui.html
//	Swagger-UI 3.x 확인
//	http://localhost[:8080]/{your-app-root}/swagger-ui/index.html

	@Bean
	public Docket swaggerApi() {
		return new Docket(DocumentationType.SWAGGER_2)
				.apiInfo(this.swaggerInfo())
				.select()
				.apis(RequestHandlerSelectors.any())
				.paths(PathSelectors.any())
				.build()
				.useDefaultResponseMessages(true);
	}
	
	private ApiInfo swaggerInfo() {
		return new ApiInfoBuilder()
				.title("Spring Boot API Documentation")
				.description("where is my home Swagger")
				.version("1.0.0")
				.build();
	}

}