package com.ssafy;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@SpringBootApplication
@MapperScan(basePackages = {"com.ssafy.**.mapper"})
public class WhereIsMyHomeApplication implements WebMvcConfigurer{

	public static void main(String[] args) {
		SpringApplication.run(WhereIsMyHomeApplication.class, args);
	}

}
