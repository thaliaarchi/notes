# Trivia about Rust Types

by Jon Gjengset [[Twitter](https://twitter.com/jonhoo/status/1532761983606411264)]
[[r/rust](https://www.reddit.com/r/rust/comments/v4dnaj/twitter_thread_with_trivia_about_rust_types/)]

transcribed by Jimmy Hartzell [[blog](https://www.thecodedmessage.com/posts/trivia-rust-types/)]

organized by myself

## `_`

Did you know that whether or not `let _ = x` should move `x` is actually
[fairly subtle](https://github.com/rust-lang/rust/issues/10488)?

## [`bool`](https://doc.rust-lang.org/std/primitive.bool.html)

Did you know that `bool` isn’t just “stored as a byte”, the compiler straight up
declares its representation as [the same as that of `u8`](https://github.com/rust-lang/rust/blob/master/compiler/rustc_middle/src/ty/layout.rs#L676-L682)?

## `{integer}`

Did you know that fasterthanlime’s [most recent article](https://fasterthanli.me/articles/the-curse-of-strong-typing#different-kinds-of-numbers)
does a great job at explaining `{integer}`?

## [`u8`](https://doc.rust-lang.org/std/primitive.u8.html#)

Did you know that as of Rust 1.60, you can now use [`u8::escape_ascii`](https://doc.rust-lang.org/std/primitive.u8.html#method.escape_ascii)
to get an iterator of the bytes needed to escape that byte character in most
contexts.

## [`u32`](https://doc.rust-lang.org/std/primitive.u32.html)

Did you know that `u32` now has associated constants for [`MIN`](https://doc.rust-lang.org/std/primitive.u32.html#associatedconstant.MIN)
and [`MAX`](https://doc.rust-lang.org/std/primitive.u32.html#associatedconstant.MAX),
so you no longer need to use [`std::u32::MIN`](https://doc.rust-lang.org/std/u32/constant.MIN.html)
and can use `u32::MIN` directly instead?

## [`u128`](https://doc.rust-lang.org/std/primitive.u128.html)

Did you know that even though we got `u128` a long time ago now, we
[still don’t have `repr(128)`](https://github.com/rust-lang/rust/issues/56071)?

## `u256`

Did you know that because Rust compiles through LLVM, we’re sort of constrained
to the primitive types LLVM supports, and [LLVM itself only goes up to 128](https://llvm.org/doxygen/classllvm_1_1Type.html#pub-static-methods)?

## [`usize`](https://doc.rust-lang.org/std/primitive.usize.html)

Did you know that `usize` isn’t really “the size of a pointer”. Instead, it’s
more like “the size of a pointer address difference”, and the two can be
[fairly different](https://github.com/rust-lang/rust/issues/95228)!

## [`f32`](https://doc.rust-lang.org/std/primitive.f32.html)/[`f64`](https://doc.rust-lang.org/std/primitive.f32.html)

Did you know that in Rust 1.62, [we’ll get](https://github.com/rust-lang/rust/pull/95431)
a deterministic ordering function, [`total_cmp`](https://doc.rust-lang.org/std/primitive.f32.html#method.total_cmp)
for floating point numbers?

## `*`

Did you know that `*` is (mostly) just syntax sugar for the [`std::ops::Mul`](https://doc.rust-lang.org/std/ops/trait.Mul.html)
trait?

## [`std::num::Wrapping<T>`](https://doc.rust-lang.org/std/num/struct.Wrapping.html)

Did you know that there used to also be a trait accompanying `Wrapping`,
`WrappingOps`, that was [removed](https://github.com/rust-lang/rust/pull/23549)
last minute before 1.0?

## `T`

Did you know that `T` [doesn’t imply ownership](https://github.com/pretzelhammer/rust-blog/blob/master/posts/common-rust-lifetime-misconceptions.md)?
When we say a type is generic over `T`, that `T` can just as easily be a
reference to something on the stack, and the type system will still be happy.
Even `T: 'static` doesn’t imply owned — consider `&'static str` for example.

## [`&mut T`](https://doc.rust-lang.org/std/primitive.reference.html)

Did you know that while `&mut T` is defined as meaning “mutable reference” in
the Rust reference, you’re often better off thinking of it as
“mutually-exclusive reference”, as [described by David Tolnay](https://docs.rs/dtolnay/latest/dtolnay/macro._02__reference_types.html).

## [`*const T`](https://doc.rust-lang.org/std/primitive.pointer.html)

Did you know that, at least for the time being, `*const T` and `*mut T` are
[more or less equivalent](https://github.com/rust-lang/unsafe-code-guidelines/issues/257)?

## [`std::ptr::NonNull<T>`](https://doc.rust-lang.org/std/ptr/struct.NonNull.html)

Did you know that one of the super neat features of `NonNull` is that it enables
the same niche optimization that regular references and the [`NonZero*`](https://doc.rust-lang.org/std/num/struct.NonZeroU64.html)
types get, where `Option<NonNull<T>>` is the same size as `*mut T`?

## [`#[feature(raw_ref_op)] &raw const T`](https://rust-lang.github.io/rfcs/2582-raw-reference-mir-operator.html)

Did you know that [originally](https://github.com/RalfJung/rfcs/blob/fd4b4cd769300cfde5d54865d227990b71b762d1/text/0000-raw-reference-operator.md)
the intention was to have `&const raw` variable be just a MIR construct and let
`&variable as *const _` be automatically changed to `&const raw`?

## [`[T; N]`](https://doc.rust-lang.org/std/primitive.array.html)

Did you know that while *most* trait implementations for arrays now use const
generics to impl for any length `N`, [we can’t *yet* do the same for `Default`](https://github.com/rust-lang/rust/blob/e40d5e83dc133d093c22c7ff016b10daa4f40dcf/library/core/src/array/mod.rs#L371-L394).

## `&[u8]`

Did you know that `&[u8]` implements [`Read`](https://doc.rust-lang.org/std/primitive.slice.html#impl-Read)
and [`Write`](https://doc.rust-lang.org/std/primitive.slice.html#impl-Write)? So
for anything that takes `impl Read`, you can provide `&mut` slice instead! Comes
in handy for testing. Note that the slice itself is shortened for each read,
hence `&mut &[u8]`.

## [`struct S`](https://doc.rust-lang.org/reference/items/structs.html)

Did you know that `struct S` implicitly declares a constant called `S`, which is
why you can make one using just `S`?

## [`struct S<const C: usize>`](https://github.com/rust-lang/rfcs/blob/master/text/2000-const-generics.md)

Did you know that with Rust 1.59.0 you can now [give `C` a default value](https://blog.rust-lang.org/2022/02/24/Rust-1.59.0.html#const-generics-defaults-and-interleaving)?

## [`()`](https://doc.rust-lang.org/std/primitive.unit.html)

Did you know that `()` implements [`FromIterator`](https://doc.rust-lang.org/std/primitive.unit.html#impl-FromIterator%3C()%3E),
so you can `.collect::<Result<(), E>>` to *just* see if anything in an iterator
erred?

## `((), ())`

Did you know that `((), ())` and `()` [have the same hash](https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&gist=894b78e8ee2721440aa8dea5e35f9dc3)?

## [`(T,)`](https://doc.rust-lang.org/nightly/reference/expressions/tuple-expr.html)

Did you know that the trailing comma is to distinguish one-element tuples
from parenthetical expressions?

## [`impl Trait`](https://doc.rust-lang.org/reference/types/impl-trait.html)

Did you know that `impl Trait` in argument position and `impl Trait` in return
position represent completely different type constructs, even though they “feel”
related?

## [`for<'a> Trait<'a>`](https://doc.rust-lang.org/reference/trait-bounds.html#higher-ranked-trait-bounds)

Did you know that you can use `for<'a>` to say that a bound has to hold for
*any* lifetime `'a`, not just a *specific* lifetime you happen to have available
at the time. For example, `<T> for<'a>: &'a T: Read` says that *any* shared
reference to a `T` must implement `Read`.

## [`Self`](https://doc.rust-lang.org/std/keyword.SelfTy.html)

Did you know that `fn foo(self)` is syntactic sugar for `fn foo(self: Self)`,
and that [one day](https://github.com/rust-lang/rust/issues/44874) you’ll be
able to use other types for `self` that involve `Self`, like
`fn foo(self: Arc<Self>)`?

## [`fn`](https://doc.rust-lang.org/std/primitive.fn.html)

Specifically, did you know that the name of a function is *not* an `fn`? It’s a
[`FnDef`](https://doc.rust-lang.org/nightly/nightly-rustc/rustc_middle/ty/sty/enum.TyKind.html#variant.FnDef),
which can then be [coerced](https://github.com/rust-lang/rust/issues/86654#issuecomment-869173835)
to a [`FnPtr`](https://doc.rust-lang.org/nightly/nightly-rustc/rustc_middle/ty/sty/enum.TyKind.html#variant.FnPtr)?

## [`Fn`](https://doc.rust-lang.org/std/ops/trait.Fn.html)

Did you know that until Rust 1.35.0, `Box<T> where T: Fn` did not `impl Fn`, so
you [couldn’t (easily) call boxed closures](https://github.com/rust-lang/rust/pull/55431)!

## [`FnOnce`](https://doc.rust-lang.org/std/ops/trait.FnOnce.html)

Did you know that until Rust 1.35, you couldn’t call a `Box<dyn FnOnce>` and
[needed a special type](https://github.com/rust-lang/rust/issues/28796)
(`FnBox`) for it! This was because it requires [“unsized rvalues”](https://github.com/rust-lang/rust/issues/48055)
to implement, which are still unstable today.

## [`Option<T>`](https://doc.rust-lang.org/std/option/enum.Option.html)

Did you know that `Option<T>` [implements `IntoIterator`](https://doc.rust-lang.org/std/option/enum.Option.html#impl-IntoIterator),
yielding 0/1 elements, and you can then call [`Iterator::flatten`](https://doc.rust-lang.org/std/iter/trait.Iterator.html#method.flatten)
to make that be 0/n elements if `T: IntoIterator`?

## [`Result<T, E>`](https://doc.rust-lang.org/std/result/enum.Result.html)

Did you know that Rust originally (pre-1.0) had both `Result` *and* an `Either`
type? They decided to remove `Either` [way back in 2013](https://github.com/rust-lang/rust/issues/9157)

## [`std::ops::ControlFlow<B, C>`](https://doc.rust-lang.org/std/ops/enum.ControlFlow.html)

Did you know that `ControlFlow` is really a stepping stone towards making `?`
work for other types than `Option` and `Result`? The full design has gone
through a *lot* of iterations, but the latest and greatest is
[RFC #3058](https://rust-lang.github.io/rfcs/3058-try-trait-v2.html).

## [`!`](https://doc.rust-lang.org/std/primitive.never.html)

Did you know that [`std::convert::Infallible`](https://doc.rust-lang.org/std/convert/enum.Infallible.html)
is the “original” `!`, and that the plan is to one day replace `Infallible` with
a type alias for `!`?

## [`std::panic::PanicInfo`](https://doc.rust-lang.org/std/panic/struct.PanicInfo.html)

Did you know that since `PanicInfo` is in `core`, its [`Display`](https://doc.rust-lang.org/std/panic/struct.PanicInfo.html#impl-Display)
implementation [cannot access the panic data](https://github.com/rust-lang/rust/blob/352e621368c31d7b4a6362e081586cdb931ba020/library/core/src/panic/panic_info.rs#L159-L162)
if it’s a `String` (since it can’t name that type), so trying to print the
`PanicInfo` after a `std::panic::panic_any(format!("x y z"))` won’t print
`"x y z"`?

## [`Vec<T>`](https://doc.rust-lang.org/std/vec/struct.Vec.html)

Did you know that [`Vec::swap_remove`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.swap_remove)
is *way* faster than [`Vec::remove`](https://doc.rust-lang.org/std/vec/struct.Vec.html#method.remove),
if you can tolerate changes to ordering?

Did you know that the smallest non-zero capacity for a `Vec<T>`
[depends on the size of `T`](https://github.com/rust-lang/rust/blob/9a74608543d499bcc7dd505e195e8bfab9447315/library/alloc/src/raw_vec.rs#L106-L110)?

## [`Vec<()>`](https://doc.rust-lang.org/std/vec/struct.Vec.html)

Did you know that since `()` is a zero-sized type, and the vector never actually
has to store any data, the capacity of `Vec<()>` is `usize::MAX`!

## [`std::collections::HashMap<K, V>`](https://doc.rust-lang.org/std/collections/struct.HashMap.html)

Did you know that the Rust devs are working on a [“raw” entry API](https://github.com/rust-lang/rust/issues/56167)
for `HashMap` that allows you to (unsafely) avoid re-hashing a key you’ve
already hashed?

## [`std::collections::BTreeMap<K, V>`](https://doc.rust-lang.org/std/collections/struct.BTreeMap.html)

Did you know that `BTreeMap` is one of the few collections that still
[doesn’t have a `drain` method](https://github.com/rust-lang/rust/issues/81074)?

## [`std::ops::Range<Idx>`](https://doc.rust-lang.org/std/ops/struct.Range.html)

Did you know that there’s been [a *lot* of debate](https://github.com/rust-lang/rust/pull/21846)
around whether or not the `Range` types should be [`Copy`](https://doc.rust-lang.org/std/marker/trait.Copy.html)?

## [`std::hash::Hash`](https://doc.rust-lang.org/std/hash/trait.Hash.html)

Did you know that Hash is responsible for not just
[one](https://github.com/rust-lang/rust/issues/29263), but
[*two*](https://github.com/rust-lang/rust/issues/65744) of the issues on the
[Rust 2 breakage wishlist](https://github.com/rust-lang/rust/issues?q=label%3Arust-2-breakage-wishlist)?

## [`std::fmt::Debug`](https://doc.rust-lang.org/std/fmt/trait.Debug.html)

Did you know that the [`Formatter`](https://doc.rust-lang.org/std/fmt/struct.Formatter.html)
argument to `Debug::fmt` makes it *really* easy to customize debug
representations for structs, enums, lists, and sets? See the `debug_*` methods
on it.

## [`std::fmt::Formatter`](https://doc.rust-lang.org/std/fmt/struct.Formatter.html)

Did you know that `Formatter` is *super* easy to use if you want more control
over debugging for a custom type? For example, to emit a “list-like” type, just
`Formatter::debug_list().entries(self.0.iter()).finish()`.

## [`std::any::Any`](https://doc.rust-lang.org/std/any/trait.Any.html)

Did you know that `Any` is *really* non-magical? It just has a blanket
implementation for all `T` that returns `TypeId::of::<T>()`, and to downcast it
simply compares the return value of that trait method to see if it’s safe to
cast to downcast to a type! [`TypeId`](https://doc.rust-lang.org/std/any/struct.TypeId.html)
*is* magic though.

## [`Box<T>`](https://doc.rust-lang.org/std/boxed/struct.Box.html)

Did you know that `Box<T>` is a [`#[fundamental]`](https://rust-lang.github.io/rfcs/1023-rebalancing-coherence.html)
type, which means that it’s exempt from the normal rules that don’t allow you to
implement foreign traits for foreign types (assuming `T` is a local type)?

## [`std::borrow::Cow<T>`](https://doc.rust-lang.org/std/borrow/enum.Cow.html)

Did you know that there used to be a special `IntoCow` trait, but it was
[deprecated](https://github.com/rust-lang/rust/issues/27735) before 1.0 was
released!

## [`std::borrow::Cow<str>`](https://doc.rust-lang.org/std/borrow/enum.Cow.html)

Did you know that because `Cow<'a, T>` is covariant in `'a`; you can always
assign `Cow::Borrowed("some string")` to one no matter what it originally held?

## [`std::pin::Pin<T>`](https://doc.rust-lang.org/std/pin/struct.Pin.html)

Did you know that the names `Pin` and [`Unpin`](https://doc.rust-lang.org/std/marker/trait.Unpin.html)
where [heavily debated](https://github.com/rust-lang/rust/issues/55766#issuecomment-438789462)?
`Pin` was almost called `Pinned`, for example.

## [`std::mem::MaybeUninit<T>`](https://doc.rust-lang.org/std/mem/union.MaybeUninit.html)

Did you know that `MaybeUninit` arose because the previous mechanism,
[`std::mem::uninitialized`](https://doc.rust-lang.org/std/mem/fn.uninitialized.html),
produced *immediate* undefined behavior when invoked with most types (like
`uninitialized::<bool>()`).

## [`std::marker::PhantomData<T>`](https://doc.rust-lang.org/std/marker/struct.PhantomData.html)

Did you know that it’s actually kind of tricky to
[define `PhantomData` yourself](https://github.com/dtolnay/ghost)?

## [`struct InvariantLifetime<'id>(PhantomData<*mut &'id ()>);`](https://gitlab.mpi-sws.org/FP/ghostcell/-/blob/master/ghostcell/src/lib.rs#L44)

Did you know that [`PhantomData<T>`](https://doc.rust-lang.org/std/marker/struct.PhantomData.html)
has variance like `T`, and `*mut T` is invariant over `T`, and so by placing a
lifetime inside `T` you make the outer type invariant over that lifetime?

## [`std::cell::UnsafeCell<T>`](https://doc.rust-lang.org/std/cell/struct.UnsafeCell.html)

Did you know that `UnsafeCell` is one of those types that the compiler needs
“special magic” for because it has to instruct LLVM to *not* assume Rust’s
normal aliasing rules hold once code traverses the boundary of any `UnsafeCell`?

## [`std::cell::RefCell<T>`](https://doc.rust-lang.org/std/cell/struct.RefCell.html)

Did you know that [`RefCell::replace`](https://doc.rust-lang.org/std/cell/struct.RefCell.html#method.replace)
allows you to replace a value in-place directly like [`std::mem::replace`](https://doc.rust-lang.org/std/mem/fn.replace.html)?

## [`std::rc::Rc<T>`](https://doc.rust-lang.org/std/rc/struct.Rc.html)

Did you know that the `Rc` type was [among the arguments](https://github.com/rust-lang/rust/issues/24456)
for why [`std::mem::forget`](https://doc.rust-lang.org/std/mem/fn.forget.html)
shouldn’t be marked as unsafe?

## [`std::sync::Arc<T>`](https://doc.rust-lang.org/std/sync/struct.Arc.html)

Did you know that `Arc` has a [`make_mut`](https://doc.rust-lang.org/std/sync/struct.Arc.html#method.make_mut)
method that effectively gives you copy-on-write? Given a `&mut Arc<T>`, it will
either give you `&mut T` if there are no other `Arc`s, or it will clone `T`,
make the `Arc<T>` point to that new `T`, and then give you a `&mut` to it!

## [`std::sync::Mutex<T>`](https://doc.rust-lang.org/std/sync/struct.Mutex.html)/[`RwLock`](https://doc.rust-lang.org/std/sync/struct.RwLock.html)/[`Condvar`](https://doc.rust-lang.org/std/sync/struct.Condvar.html)

Did you know that Mara is doing some [*awesome* work](https://github.com/rust-lang/rust/issues/93740)
on making `Mutex`, `RwLock`, and `Condvar` much better on a wide array on
platforms?

## [`std::sync::Weak<T>`](https://doc.rust-lang.org/std/sync/struct.Weak.html)

Did you know that [actual deallocation logic](https://github.com/rust-lang/rust/blob/7e9b92cb43a489b34e2bcb8d21f36198e02eedbc/library/alloc/src/sync.rs#L1108-L1109)
for [`Arc`](https://doc.rust-lang.org/std/sync/struct.Arc.html) is implemented
in `Weak`, and is invoked by considering all copies of a particular `Arc<T>` to
*collectively* hold a single `Weak<T>` between them?

## [`std::sync::atomic::AtomicU32`](https://doc.rust-lang.org/std/sync/atomic/struct.AtomicU32.html)

Did you know that you’ll often want [`compare_exchange_weak`](https://doc.rust-lang.org/std/sync/atomic/struct.AtomicU32.html#method.compare_exchange_weak)
over [`compare_exchange`](https://doc.rust-lang.org/std/sync/atomic/struct.AtomicU32.html#method.compare_exchange)
to get [more efficient code on ARM cores](https://devblogs.microsoft.com/oldnewthing/20180329-00/?p=98375).

## [`std::sync::mpsc`](https://doc.rust-lang.org/std/sync/mpsc/index.html)

Did you know that `std::sync::mpsc` has had a [known bug since 2017](https://github.com/rust-lang/rust/issues/39364),
and that the implementation [may be replaced entirely](https://github.com/rust-lang/rust/pull/93563)
with the [crossbeam channel](https://docs.rs/crossbeam-channel/latest/crossbeam_channel/)
implementation?

## [`std::thread::Thread`](https://doc.rust-lang.org/std/thread/struct.Thread.html)

Did you know that the [`ThreadId`](https://doc.rust-lang.org/std/thread/struct.ThreadId.html)
that’s available for each `Thread` is entirely a `std` construct? Creating a
`ThreadId` [simply increments](https://github.com/rust-lang/rust/blob/09d52bc5d4260bac8b9a2ea8ac7a07c5c72906f1/library/std/src/thread/mod.rs#L1031)
a global static counter under a lock.

## [`std::process::Child`](https://doc.rust-lang.org/std/process/struct.Child.html)

Did you know that `std` has [three different ways](https://github.com/rust-lang/rust/blob/master/library/std/src/sys/unix/process/process_unix.rs)
to spawn a child process on Linux (`posix_spawn`, `clone3`/`exec`,
`fork`/`exec`), depending on what capabilities your kernel version has?

## [`std::future::Ready<T>`](https://doc.rust-lang.org/std/future/struct.Ready.html)

Did you know that these days you can just use [`async move { x }`](https://doc.rust-lang.org/std/keyword.async.html)
instead of [`future::ready(x)`](https://doc.rust-lang.org/std/future/fn.ready.html).
The main reason to still use `future::ready(x)` is that you can name the future
it returns, which is harder with `async` (without [`type_alias_impl_trait`](https://github.com/rust-lang/rust/issues/63063),
that is).

## [`std::task::Waker`](https://doc.rust-lang.org/std/task/struct.Waker.html)

Did you know that `Waker` is [secretly just](https://doc.rust-lang.org/std/task/struct.RawWakerVTable.html)
a `dyn std::task::Wake + Clone` done in a way that doesn’t require a wide
pointer or support for multi-trait dynamic dispatch?

## [`std::fs::File`](https://doc.rust-lang.org/std/fs/struct.File.html)

Did you know that there are implementations of [`Read`](https://doc.rust-lang.org/std/io/trait.Read.html),
[`Write`](https://doc.rust-lang.org/std/io/trait.Write.html), and [`Seek`](https://doc.rust-lang.org/std/io/trait.Seek.html)
for `&File` as well, so multiple threads can share a single `File` and call
those concurrently. Whether they *should* is a different question of course.

## [`std::os::unix::net::UnixStream`](https://doc.rust-lang.org/std/os/unix/net/struct.UnixStream.html)

Did you know that (on nightly) you can pass UNIX file descriptors over
`UnixStream`s too, and thereby [give another process access](https://doc.rust-lang.org/std/os/unix/net/struct.SocketAncillary.html#method.add_fds)
to a file it may not otherwise be able to open?

## [`std::net::TcpStream`](https://doc.rust-lang.org/std/net/struct.TcpStream.html)

Did you know that in its default configuration, `TcpStream` uses
[Nagle’s Algorithm](https://en.wikipedia.org/wiki/Nagle%27s_algorithm) to
schedule packet sends, which can introduce unfortunate latency spikes. If you’re
particularly latency sensitive, consider calling `TcpStream::set_nodelay(true)`.

## [`std::ffi::c_void`](https://doc.rust-lang.org/std/ffi/enum.c_void.html)

Did you know that the whole `c_void` type is a collection of hacks to try to
work around the [lack of extern types](https://github.com/rust-lang/rust/issues/43467)?

## [`std::ffi::CStr`](https://doc.rust-lang.org/std/ffi/struct.CStr.html)

Did you know that [`CStr::default`](https://doc.rust-lang.org/std/ffi/struct.CStr.html#method.default)
creates a `CStr` that points to a const string `"\0"` stored in the binary text
segment, which means all default `CStr`s point to the same (non-null) string!

## [`std::ffi::OsString`](https://doc.rust-lang.org/std/ffi/struct.OsString.html)

Did you know that there are per-platform extension traits for `OsString` that
bake in the assumptions you can safely make on that platform? Such as
strings being [`[u8]` on Unix](https://doc.rust-lang.org/std/os/unix/ffi/trait.OsStringExt.html)
and [UTF-16 on Windows](https://doc.rust-lang.org/std/os/windows/ffi/trait.OsStringExt.html).
