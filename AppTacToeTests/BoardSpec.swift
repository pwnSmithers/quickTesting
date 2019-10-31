/// Copyright (c) 2019 Smithers


import Quick
import Nimble
@testable import AppTacToe

class BoardSpec: QuickSpec {
  override func spec() {
    
    var board : Board!
    
    beforeEach{
        board = Board()
    }
    
    describe("playing"){
        context("a single move"){
            it("should switch to nought"){
                try! board.playRandom()
                expect(board.state).to(equal(.playing(.nought)))
            }
        }
        
        context("playing two moves") {
            it("should switch back to cross") {
                try! board.playRandom()
                try! board.playRandom()
                expect(board.state) == .playing(.cross)
            }
        }
        
        context("a winning move") {
            it("should switch to won state") {
                //Arrange
                try! board.play(at:0)
                try! board.play(at: 1)
                try! board.play(at: 3)
                try! board.play(at: 2)
                
                // Act
                try! board.play(at: 6)
                
                //Assert
                expect(board.state) == .won(.cross)
                
                print(board)
            }
        }
        
        context("a move leaving no remaining moves") {
            it("should switch to draw state") {
                //Arrange
                try! board.play(at: 0)
                try! board.play(at: 2)
                try! board.play(at: 1)
                try! board.play(at: 3)
                try! board.play(at: 4)
                try! board.play(at: 8)
                try! board.play(at: 6)
                try! board.play(at: 7)
                
                //Act
                try! board.play(at: 5)
                
                //Assert
                expect(board.state) == Board.State.draw
            }
        }
        
        context("a move that has already been played") {
            it("should throw an error") {
                try! board.play(at: 0)
                expect{try board.play(at: 0)}
                    .to(throwError(Board.PlayError.alreadyPlayed))
            }
        }
        
        context("a move while the game has already been won") {
            fit("should throw an error") {
                //arrange
                try! board.play(at: 0)
                try! board.play(at: 1)
                try! board.play(at: 3)
                try! board.play(at: 2)
                try! board.play(at: 6)
                
                //act & assert
                expect { try board.play(at: 0) }
                    .to(throwError(Board.PlayError.noGame))
            }
        }
    }

  }
}
