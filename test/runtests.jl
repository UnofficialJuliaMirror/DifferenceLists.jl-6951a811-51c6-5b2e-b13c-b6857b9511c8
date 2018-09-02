using DifferenceLists

@test collect(dl(1, 2, 3)) == [1,2,3]
@test collect(dl()) == []
@test collect(dl(1)) == [1]
@test collect(dl(1, dl(2, 3), 4)) == [1, dl(2, 3), 4]
@test collect(push(2, push(1, dl(7, 8, 9)))) == [7,8,9,1,2]
@test collect(pushfirst(1, pushfirst(2, dl(7, 8, 9)))) == [1, 2, 7, 8, 9]
@test collect(concat(dl(1, 2), dl(3, 4))) == [1,2,3,4]
@test collect(dl(1, 2)(dl(3, 4), dl(5, 6, 7))) == [1, 2, 3, 4, 5, 6, 7]
