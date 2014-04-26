

function testSort()
testMat = [3,2,1;5,7,1;2,9,0]

[B, index] = sort(testMat,2)
B
[m,n] = size(B)
for i=1:m
    for j=1:n
        if(index(i,j) == 1)   
            class(int32(index(i,j)))
        end
    end
end
