package site.metacoding.red.web.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class CMRespDto<T> {//공통 응답 DTO
	private Integer code; //1 정상, -1 실패
	private String msg; //실패의 이유, 성공의 이유
	private T data; //타입이 항상 다름
}
