# 인터페이스 설계 기술서 (IDD) - Frontend ↔ Backend Shared Specification

| 항목 | 상세 내용 |
|:---|:---|
| **문서 ID** | [PROJ-IDD-SHARED-YYYYMMDD] |
| **인터페이스 주체** | Frontend CSCI ↔ Backend CSCI |
| **작성 일자** | [CREATION_DATE] |

---

## 1. 서론

이 문서는 Frontend와 Backend CSCI 간의 통신 규약 및 데이터 구조를 상세히 정의합니다.

### 1.1 참조 문서
* **공통 규약:** **SSDD 3.1**을 준수한다
* **Frontend 요구사항:** **SRS-FE** ([PROJ-SRS-FE-YYYYMMDD]) 참조
* **Backend 요구사항:** **SRS-BE** ([PROJ-SRS-BE-YYYYMMDD]) 참조

### 1.2 문서 목적
[DOCUMENT_PURPOSE]
<!-- Example: 정합성 및 중복 최소화를 위해 Frontend와 Backend 간 단일 인터페이스 규격을 제공하여 LLM이 일관된 API 코드를 생성하도록 지원 -->

## 2. 인터페이스 개요 및 공통 규약

### 2.1 통신 프로토콜
* **프로토콜:** [COMMUNICATION_PROTOCOL]
  <!-- Example: HTTPS over TCP/IP -->
* **데이터 형식:** [DATA_FORMAT]
  <!-- Example: JSON (application/json) -->
* **문자 인코딩:** [CHARACTER_ENCODING]
  <!-- Example: UTF-8 -->

### 2.2 인증 및 보안
* **인증 방식:** [AUTHENTICATION_METHOD]
  <!-- Example: Bearer Token (JWT) -->
* **토큰 위치:** [TOKEN_LOCATION]
  <!-- Example: Authorization 헤더 -->
* **토큰 형식:** [TOKEN_FORMAT]
  <!-- Example: "Bearer {jwt_token}" -->

### 2.3 공통 오류 처리 규약

모든 API 호출 시 반환되는 표준 오류 메시지 구조를 정의합니다.

#### 성공 응답 구조
```json
{
  "success": true,
  "data": {
    // 실제 응답 데이터
  },
  "timestamp": "2024-01-01T00:00:00Z"
}
```

#### 오류 응답 구조
```json
{
  "success": false,
  "error": {
    "code": "[ERROR_CODE_FORMAT]",
    "message": "[ERROR_MESSAGE_FORMAT]",
    "details": "[ERROR_DETAILS_FORMAT]"
  },
  "timestamp": "2024-01-01T00:00:00Z"
}
```

### 2.4 공통 HTTP 상태 코드

| HTTP 코드 | 의미 | 사용 상황 |
|:---|:---|:---|
| **200** | OK | 성공적인 요청 처리 |
| **201** | Created | 리소스 생성 성공 |
| **400** | Bad Request | 잘못된 요청 파라미터 |
| **401** | Unauthorized | 인증 실패 |
| **403** | Forbidden | 권한 부족 |
| **404** | Not Found | 리소스 없음 |
| **500** | Internal Server Error | 서버 내부 오류 |

## 3. 인터페이스 상세 설계 (API 목록)

### 3.1 사용자 인증 관리

| ID | URI/엔드포인트 | HTTP Method | 기능 설명 | 연관 SRS ID |
|:---|:---|:---|:---|:---|
| **API-AUTH-001** | `/api/v1/auth/login` | **POST** | 사용자 인증 및 토큰 발급 | FR-FE-001, FR-BE-001 |
| **API-AUTH-002** | `/api/v1/auth/logout` | **POST** | 사용자 로그아웃 | FR-FE-002, FR-BE-002 |
| **API-AUTH-003** | `/api/v1/auth/refresh` | **POST** | 토큰 갱신 | FR-FE-003, FR-BE-003 |

#### API-AUTH-001: 사용자 로그인 (POST /api/v1/auth/login)

**요청 (Request) 데이터 상세 (Frontend → Backend)**

| 필드 | 타입 | 필수 | 설명 | 유효성 검사 |
|:---|:---|:---|:---|:---|
| `loginId` | String | O | 사용자 식별 ID | 4-50자, 영숫자 및 특수문자 |
| `password` | String | O | 비밀번호 | 8-100자 |

**요청 예시:**
```json
{
  "loginId": "user@example.com",
  "password": "securepassword123"
}
```

**응답 (Response) 데이터 상세 (Backend → Frontend)**

| 필드 | 타입 | 필수 | 설명 |
|:---|:---|:---|:---|
| `accessToken` | String | O | 인증 토큰 (JWT) |
| `refreshToken` | String | O | 토큰 갱신용 |
| `expiresIn` | Integer | O | 토큰 만료 시간 (초) |
| `user` | Object | O | 사용자 정보 |
| `user.id` | Integer | O | 사용자 ID |
| `user.name` | String | O | 사용자 이름 |
| `user.email` | String | O | 이메일 |
| `user.role` | String | O | 사용자 역할 |

**응답 예시:**
```json
{
  "success": true,
  "data": {
    "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refreshToken": "refresh_token_string",
    "expiresIn": 3600,
    "user": {
      "id": 12345,
      "name": "홍길동",
      "email": "user@example.com",
      "role": "USER"
    }
  },
  "timestamp": "2024-01-01T00:00:00Z"
}
```

---

### 3.2 사용자 관리

| ID | URI/엔드포인트 | HTTP Method | 기능 설명 | 연관 SRS ID |
|:---|:---|:---|:---|:---|
| **API-USER-001** | `/api/v1/users/{userId}` | **GET** | 특정 사용자 정보 조회 | FR-FE-101, FR-BE-101 |
| **API-USER-002** | `/api/v1/users` | **POST** | 새 사용자 생성 | FR-FE-102, FR-BE-102 |
| **API-USER-003** | `/api/v1/users/{userId}` | **PUT** | 사용자 정보 수정 | FR-FE-103, FR-BE-103 |

#### API-USER-001: 사용자 정보 조회 (GET /api/v1/users/{userId})

**경로 파라미터:**
| 필드 | 타입 | 필수 | 설명 |
|:---|:---|:---|:---|
| `userId` | Integer | O | 조회할 사용자 ID |

**쿼리 파라미터:**
| 필드 | 타입 | 필수 | 설명 | 기본값 |
|:---|:---|:---|:---|:---|
| `includeProfile` | Boolean | X | 프로필 정보 포함 여부 | false |

**응답 데이터:**
```json
{
  "success": true,
  "data": {
    "id": 12345,
    "name": "홍길동",
    "email": "user@example.com",
    "role": "USER",
    "createdAt": "2024-01-01T00:00:00Z",
    "profile": {
      // includeProfile=true 시에만 포함
      "avatar": "https://example.com/avatar.jpg",
      "bio": "사용자 소개"
    }
  },
  "timestamp": "2024-01-01T00:00:00Z"
}
```

---

### 3.3 [추가 API 그룹]

[ADDITIONAL_API_GROUPS]
<!-- Example: 게시물 관리, 파일 업로드, 알림 등 추가 API 그룹을 여기에 정의 -->

## 4. 데이터 모델 정의

### 4.1 공통 데이터 타입

| 타입 | 설명 | 형식 | 예시 |
|:---|:---|:---|:---|
| **Timestamp** | ISO 8601 UTC 시간 | String | "2024-01-01T00:00:00Z" |
| **UUID** | 고유 식별자 | String | "123e4567-e89b-12d3-a456-426614174000" |
| **Email** | 이메일 주소 | String | "user@example.com" |

### 4.2 열거형 (Enum) 정의

#### UserRole
```json
{
  "ADMIN": "관리자",
  "USER": "일반 사용자",
  "GUEST": "게스트"
}
```

#### Status
```json
{
  "ACTIVE": "활성",
  "INACTIVE": "비활성",
  "PENDING": "대기중",
  "SUSPENDED": "정지"
}
```

## 5. API 버전 관리

### 5.1 버전 관리 정책
[VERSION_MANAGEMENT_POLICY]
<!-- Example: URI 경로에 버전 포함 (/api/v1/), 하위 호환성 유지 정책 -->

### 5.2 변경 이력
| 버전 | 변경 일자 | 주요 변경사항 |
|:---|:---|:---|
| **v1.0** | [INITIAL_VERSION_DATE] | 초기 API 설계 |

## 6. 테스트 및 검증

### 6.1 API 테스트 케이스
[API_TEST_CASES]
<!-- Example: 각 API별 정상/비정상 케이스, 경계값 테스트 -->

### 6.2 계약 테스트 (Contract Testing)
[CONTRACT_TESTING]
<!-- Example: Frontend와 Backend 간 API 계약 검증 방법 -->

## 7. 개발 지원 도구

### 7.1 API 문서화
[API_DOCUMENTATION_TOOLS]
<!-- Example: Swagger/OpenAPI 스펙 제공, Postman Collection -->

### 7.2 Mock 서버
[MOCK_SERVER_SETUP]
<!-- Example: Frontend 개발용 Mock API 서버 설정 방법 -->