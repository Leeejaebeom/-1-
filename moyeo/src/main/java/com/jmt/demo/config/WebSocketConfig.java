package com.jmt.demo.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

/**
 * 	@EnableWebSocketMessageBroker: WebSocket 메시지 브로커를 활성화
 * 	configureMessageBroker: 메시지 브로커를 설정 /topic으로 시작하는 목적지를 브로커로 라우팅
 * 	registerStompEndpoints: /chat 엔드포인트를 등록 SockJS를 사용하여 WebSocket을 지원하지 않는 브라우저에서도 연결할 수 있게 함
 */
@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    @Override
    public void configureMessageBroker(MessageBrokerRegistry config) {
        config.enableSimpleBroker("/topic");
        config.setApplicationDestinationPrefixes("/app");
    }

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/chat").withSockJS();
    }
}