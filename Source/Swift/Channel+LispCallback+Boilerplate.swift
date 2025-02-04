//
// Channel+LispCallback+Boilerplate.swift
// Copyright (C) 2022 Valeriy Savchenko
//
// This file is part of EmacsSwiftModule.
//
// EmacsSwiftModule is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
//
// EmacsSwiftModule is distributed in the hope that it will be useful, but
// WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
// or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
// more details.
//
// You should have received a copy of the GNU General Public License along with
// EmacsSwiftModule. If not, see <https://www.gnu.org/licenses/>.
//
class LazyLispCallback0: AnyLazyCallback {
  let function: EmacsValue
  init(function: EmacsValue) {
    self.function = function
  }
  func call(_ env: Environment, with args: Any) throws {
    try env.funcall(function)
  }
}

class LazyLispCallback1<T: EmacsConvertible>: AnyLazyCallback {
  let function: EmacsValue
  init(function: EmacsValue) {
    self.function = function
  }
  func call(_ env: Environment, with args: Any) throws {
    if let arg = args as? T {
      try env.funcall(function, with: arg)
    }
  }
}

class LazyLispCallback2<T1: EmacsConvertible, T2: EmacsConvertible>:
  AnyLazyCallback
{
  let function: EmacsValue
  init(function: EmacsValue) {
    self.function = function
  }
  func call(_ env: Environment, with args: Any) throws {
    if let arg = args as? (T1, T2) {
      try env.funcall(function, with: arg.0, arg.1)
    }
  }
}

class LazyLispCallback3<
  T1: EmacsConvertible, T2: EmacsConvertible, T3: EmacsConvertible
>: AnyLazyCallback {
  let function: EmacsValue
  init(function: EmacsValue) {
    self.function = function
  }
  func call(_ env: Environment, with args: Any) throws {
    if let arg = args as? (T1, T2, T3) {
      try env.funcall(function, with: arg.0, arg.1, arg.2)
    }
  }
}

class LazyLispCallback4<
  T1: EmacsConvertible, T2: EmacsConvertible, T3: EmacsConvertible,
  T4: EmacsConvertible
>: AnyLazyCallback {
  let function: EmacsValue
  init(function: EmacsValue) {
    self.function = function
  }
  func call(_ env: Environment, with args: Any) throws {
    if let arg = args as? (T1, T2, T3, T4) {
      try env.funcall(function, with: arg.0, arg.1, arg.2, arg.3)
    }
  }
}

class LazyLispCallback5<
  T1: EmacsConvertible, T2: EmacsConvertible, T3: EmacsConvertible,
  T4: EmacsConvertible, T5: EmacsConvertible
>: AnyLazyCallback {
  let function: EmacsValue
  init(function: EmacsValue) {
    self.function = function
  }
  func call(_ env: Environment, with args: Any) throws {
    if let arg = args as? (T1, T2, T3, T4, T5) {
      try env.funcall(function, with: arg.0, arg.1, arg.2, arg.3, arg.4)
    }
  }
}

extension Channel {
  /// Make a Swift callback out of an Emacs function.
  ///
  /// This allows us to use Emacs functions as callbacks in Swift APIs.
  /// Please, see <doc:AsyncCallbacks> for more details on that.
  ///
  /// - Parameter function: a Lisp function to turn into a callback.
  /// - Returns: a callback that if called, will eventually call the given function.
  public func callback(_ function: EmacsValue)
    -> () -> Void
  {
    return { [self] in
      register(
        callback: LazyLispCallback0(function: function), args: ())
    }
  }
  /// Make a Swift callback out of an Emacs function.
  ///
  /// This allows us to use Emacs functions as callbacks in Swift APIs.
  /// Please, see <doc:AsyncCallbacks> for more details on that.
  ///
  /// - Parameter function: a Lisp function to turn into a callback.
  /// - Returns: a callback that if called, will eventually call the given function.
  public func callback<T: EmacsConvertible>(_ function: EmacsValue)
    -> (T) -> Void
  {
    return { [self] arg in
      register(
        callback: LazyLispCallback1<T>(function: function), args: arg)
    }
  }
  /// Make a Swift callback out of an Emacs function.
  ///
  /// This allows us to use Emacs functions as callbacks in Swift APIs.
  /// Please, see <doc:AsyncCallbacks> for more details on that.
  ///
  /// - Parameter function: a Lisp function to turn into a callback.
  /// - Returns: a callback that if called, will eventually call the given function.
  public func callback<T1: EmacsConvertible, T2: EmacsConvertible>(
    _ function: EmacsValue
  ) -> (T1, T2) -> Void {
    return { [self] (arg1, arg2) in
      register(
        callback: LazyLispCallback2<T1, T2>(function: function),
        args: (arg1, arg2))
    }
  }
  /// Make a Swift callback out of an Emacs function.
  ///
  /// This allows us to use Emacs functions as callbacks in Swift APIs.
  /// Please, see <doc:AsyncCallbacks> for more details on that.
  ///
  /// - Parameter function: a Lisp function to turn into a callback.
  /// - Returns: a callback that if called, will eventually call the given function.
  public func callback<
    T1: EmacsConvertible, T2: EmacsConvertible, T3: EmacsConvertible
  >(
    _ function: EmacsValue
  ) -> (T1, T2, T3) -> Void {
    return { [self] (arg1, arg2, arg3) in
      register(
        callback: LazyLispCallback3<T1, T2, T3>(function: function),
        args: (arg1, arg2, arg3))
    }
  }
  /// Make a Swift callback out of an Emacs function.
  ///
  /// This allows us to use Emacs functions as callbacks in Swift APIs.
  /// Please, see <doc:AsyncCallbacks> for more details on that.
  ///
  /// - Parameter function: a Lisp function to turn into a callback.
  /// - Returns: a callback that if called, will eventually call the given function.
  public func callback<
    T1: EmacsConvertible, T2: EmacsConvertible, T3: EmacsConvertible,
    T4: EmacsConvertible
  >(
    _ function: EmacsValue
  ) -> (T1, T2, T3, T4) -> Void {
    return { [self] (arg1, arg2, arg3, arg4) in
      register(
        callback: LazyLispCallback4<T1, T2, T3, T4>(function: function),
        args: (arg1, arg2, arg3, arg4))
    }
  }
  /// Make a Swift callback out of an Emacs function.
  ///
  /// This allows us to use Emacs functions as callbacks in Swift APIs.
  /// Please, see <doc:AsyncCallbacks> for more details on that.
  ///
  /// - Parameter function: a Lisp function to turn into a callback.
  /// - Returns: a callback that if called, will eventually call the given function.
  public func callback<
    T1: EmacsConvertible, T2: EmacsConvertible, T3: EmacsConvertible,
    T4: EmacsConvertible, T5: EmacsConvertible
  >(
    _ function: EmacsValue
  ) -> (T1, T2, T3, T4, T5) -> Void {
    return { [self] (arg1, arg2, arg3, arg4, arg5) in
      register(
        callback: LazyLispCallback5<T1, T2, T3, T4, T5>(function: function),
        args: (arg1, arg2, arg3, arg4, arg5))
    }
  }
}
