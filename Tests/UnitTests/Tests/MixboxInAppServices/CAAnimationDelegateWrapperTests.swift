import Foundation
@testable import MixboxInAppServices
import MixboxFoundation
import XCTest

final class CAAnimationDelegateWrapperTests: TestCase {
    private let animation = CAAnimation()
    private let output = MutableBox("")
    private let notImplementedDelegate = NotImplementedDelegate()
    
    func test___this_test___works() {
        check(
            timesDelegateIsWrapped: 0,
            finish: true,
            originalDelegate: ImplementedDelegate(output: output),
            expectedOutputAfterStart:
            """
            original.start
            """,
            expectedOutputAfterStop:
            """
            original.stop(finished=true)
            """
        )
    }
    
    func test___wrappedDelegate___wraps_correctly___if_delegate_is_wrapped_1_time() {
        // This is the only test that checks passing `finish` argument
        check(
            timesDelegateIsWrapped: 1,
            finish: true,
            originalDelegate: ImplementedDelegate(output: output),
            expectedOutputAfterStart:
            """
            wrapper(0).start
            original.start
            """,
            expectedOutputAfterStop:
            """
            original.stop(finished=true)
            wrapper(0).stop(finished=true)
            """
        )
        
        check(
            timesDelegateIsWrapped: 1,
            finish: false,
            originalDelegate: ImplementedDelegate(output: output),
            expectedOutputAfterStart:
            """
            wrapper(0).start
            original.start
            """,
            expectedOutputAfterStop:
            """
            original.stop(finished=false)
            wrapper(0).stop(finished=false)
            """
        )
    }
    
    func test___wrappedDelegate___unwraps_before_wrapping___if_delegate_is_wrapped_multiple_time() {
        check(
            timesDelegateIsWrapped: 10,
            finish: true,
            originalDelegate: ImplementedDelegate(output: output),
            expectedOutputAfterStart:
            """
            wrapper(9).start
            original.start
            """,
            expectedOutputAfterStop:
            """
            original.stop(finished=true)
            wrapper(9).stop(finished=true)
            """
        )
    }
    
    func test___wrappedDelegate___supports_optionality_of_methods() {
        check(
            timesDelegateIsWrapped: 1,
            finish: true,
            originalDelegate: NotImplementedDelegate(),
            expectedOutputAfterStart:
            """
            wrapper(0).start
            """,
            expectedOutputAfterStop:
            """
            wrapper(0).stop(finished=true)
            """
        )
    }
    
    func test___wrappedDelegate___supports_optionality_of_delegate() {
        check(
            timesDelegateIsWrapped: 1,
            finish: true,
            originalDelegate: nil,
            expectedOutputAfterStart:
            """
            wrapper(0).start
            """,
            expectedOutputAfterStop:
            """
            wrapper(0).stop(finished=true)
            """
        )
    }
    
    private func check(
        timesDelegateIsWrapped: Int,
        finish: Bool,
        originalDelegate: CAAnimationDelegate?,
        expectedOutputAfterStart: String,
        expectedOutputAfterStop: String,
        file: StaticString = #file,
        line: UInt = #line)
    {
        output.value = ""
        
        let delegate = self.delegate(
            timesDelegateIsWrapped: timesDelegateIsWrapped,
            originalDelegate: originalDelegate
        )
        
        XCTAssertEqual(output.value, "")
        
        delegate?.animationDidStart?(animation)
        
        XCTAssertEqual(
            output.value,
            expectedOutputAfterStart + "\n",
            file: file,
            line: line
        )
        
        delegate?.animationDidStop?(animation, finished: finish)
        
        XCTAssertEqual(
            output.value,
            expectedOutputAfterStart + "\n" + expectedOutputAfterStop + "\n",
            file: file,
            line: line
        )
    }
    
    private func delegate(
        timesDelegateIsWrapped: Int,
        originalDelegate: CAAnimationDelegate?)
        -> CAAnimationDelegate?
    {
        var delegate: CAAnimationDelegate? = originalDelegate
        
        for wrappingIndex in 0..<timesDelegateIsWrapped {
            delegate = wrap(delegate: delegate, index: wrappingIndex)
        }
        
        return delegate
    }
    private func wrap(delegate: CAAnimationDelegate?, index: Int) -> CAAnimationDelegate? {
        return CAAnimationDelegateWrapper.wrappedDelegate(
            originalDelegate: delegate,
            onAnimationDidStart: { [output] _ in
                output.value += "wrapper(\(index)).start\n"
            },
            onAnimationDidStop: { [output] _, finished in
                output.value += "wrapper(\(index)).stop(finished=\(finished ? "true" : "false"))\n"
            }
        )
    }
}

private typealias Output = MutableBox<String>

private final class ImplementedDelegate: NSObject, CAAnimationDelegate {
    private let output: Output
    
    init(output: Output) {
        self.output = output
    }
    
    func animationDidStart(_ anim: CAAnimation) {
        output.value += "original.start\n"
    }
    
    func animationDidStop(_ anim: CAAnimation, finished: Bool) {
        output.value += "original.stop(finished=\(finished ? "true" : "false"))\n"
    }
}

private final class NotImplementedDelegate: NSObject, CAAnimationDelegate {
}
