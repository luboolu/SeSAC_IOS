import UIKit


//고차함수: 1급 객체 -> 매개변수와 반환값에 함수를 사용할 수 있음 -> map, filter, reduce

//학생 중 4.0 이상인 학생 찾기
let student = [2.2, 5.0, 4.3, 3.3, 2.8, 1.5]
var resultStudent: [Double] = []

for i in student {
    
    if i >= 4.0 {
        resultStudent.append(i)
    }
}

print(resultStudent)


//Filter

let resultFilter = student.filter { value in
    value >= 4.0
}
let resultFilter2 = student.filter { $0 >= 4.0 } //훨씬 빠르고 효율적임

print(resultFilter)
print(resultFilter2)

//원하는 영화
let movieList = [
    "괴물": "박찬욱",
    "기생충": "봉준호",
    "다리미": "안녕",
    "인터스텔라": "크리스토퍼 놀란",
    "인셉션": "크리스토퍼 놀란",
    "옥자": "봉준호"
]

//for (movieName, director) in movieList {
//    if director == "봉준호" {
//
//    }
//}

let movieResult = movieList.filter { $0.value == "봉준호"}
print(movieResult)


let movieResult2 = movieList.filter { $0.value == "봉준호"}.map{ $0.key }
print(movieResult2)

let movieResultSort = movieList.sorted(by: {$0.key < $1.key})
print(movieResultSort)

//map
let number = [1,2,3,4,5,6,7,8,9]
var resultNumber: [Int] = []

for n in number {
    resultNumber.append(n * 2)
}

let resultMap = number.map{ $0 * 2 }
print(resultMap)


//reduce
let exam = [20, 40, 100, 90, 10, 70]
var totalCount = 0

for i in exam {
    totalCount += i
}

let resultTotalCount = exam.reduce(0){ $0 + $1 } //모든 요소를 다 더하겠다
print(resultTotalCount)
