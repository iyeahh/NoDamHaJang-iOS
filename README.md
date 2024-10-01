# 🗓 노담하장 (Let's quit smoking)
## 🙅🏻 단번에 금연이 힘들 때 목표 흡연 횟수를 줄여 금연을 도와주는 앱
##### 프로젝트 기간: 2024년 9월 19일 → 2024년 9월 28일 (10일)
##### 인원: 기획 & 디자인 & 개발 총 1명
##### 최소 버전: iOS 16+

## 🧐 핵심 기능
* 하루의 목표 흡연 횟수 설정
* 실제 흡연 횟수 체크
* 캘린더, 차트로 흡연 횟수 추이 확인
* 금연 관련 기사 표시
* 매일 금연 독려 알림
* 영어 대응

## 🤓 기술 스택
* SwiftUI
* MVVM - InOut 패턴, Combine
* LinkPresentation
* Swift Charts

## 📚 라이브러리
* Alamofire
* RealmSwift
* FSCalendar

## **💡 문제 해결**

### **❓ 토픽**

**ViewModel에서 enum으로 Action 분리** 

### **❕ 해결 방법**

💡 **문제 상황:** **코드의 확장성과 유지보수성을 높이기 위해 enum으로 Action 분리**

- enum에 새로운 케이스를 추가하는 방식으로 새로운 액션을 추가하기 쉬움
- 모든 액션을 하나의 열거형으로 관리하여, 액션 처리의 흐름을 명확하게 유지

> 구현부
> 

```swift
extension HomeViewModel {
    enum Action {
        case addSmokeButtonTapped
        case viewOnTask
    }

    func action(_ action: Action) {
        switch action {
        case .viewOnTask:
            input.viewOnTask.send(())
        case .addSmokeButtonTapped:
            input.addSmokeButtonTapped.send(())
        }
    }
}
```

> 실행부
> 

```swift
viewModel.action(.viewOnTask)
viewModel.action(.addSmokeButtonTapped)
```

### **❓ 토픽**

**하위 View에 ViewModel을 전달하여 상위 View 데이터 변경**

### **❕ 해결 방법**

💡 **문제 상황: 하위 뷰의 동작 및 데이터를 상위 뷰에 전달하여 상위 뷰의 상태를 변경하려 했으나, 각 뷰에 별도의 ViewModel을 생성해 주입하니 상위 뷰의 데이터가 갱신되지 않는 문제 발생**

- 상위 뷰의 ViewModel을 하위 뷰에도 주입하여 **공유된 ViewModel**을 기반으로 하위 뷰의 상태 및 이벤트가 상위 뷰에 전달될 수 있도록 구성
- Combine 프레임워크를 활용하여 하위 뷰에서 발생하는 데이터 변경 사항이 상위 뷰에 반영되도록 함



### **❓ 토픽**

**LinkPresentation 프레임워크를 활용한 URL Link Preview로 데이터 표시**

### **❕ 해결 방법**

💡 **문제 상황: 금연 관련 기사의 URL을 제공할 때, 해당 기사의 이미지와 제목을 포함한 미리보기를 구현해야 하는 상황**

- **LPMetadataProvider**를 통해 URL의 메타데이터(이미지, 제목 등)를 비동기적으로 가져오고, 이를 **LPLinkView**로 시각화하여 링크의 미리보기를 제공
- 금연 관련 기사의 이미지와 제목을 사용자가 직관적으로 확인할 수 있음
<img width="307" alt="스크린샷 2024-10-01 오후 1 49 25" src="https://github.com/user-attachments/assets/4ff8848d-83e9-4391-8221-674ce7fd4f90">

  
### **❓ 토픽**

**Localization을 위한 영어 지원**

### **❕ 해결 방법**

💡 **문제 상황: 글로벌 사용자들을 위한 다국어 지원 필요**

- **String Catalog**를 활용하여 Localization을 구현, 한국어와 영어 대응
- 앱 내에서 자동으로 언어 선택이 이루어지며 사용자 언어 설정에 맞춘 **동적 텍스트 변환**이 가능하도록 구성
- Key Mapping을 통해 유지보수성을 높이고 일관된 언어 리소스를 관리
  
![스크린샷 2024-10-01 오후 1 26 18](https://github.com/user-attachments/assets/8f3421df-3a9f-4d75-92ac-bf5099684ab3)

    
