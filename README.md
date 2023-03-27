# StackRep (sof_user) 

iOS/Android application to list stack overflow user by their reputation.

## Getting Started

When running on an actual device please run with:
flutter run --release

--release mode will ensure the app runs smoothly with actual mobile device resources.
As --debug mode will require more resources and overload the device for debugging purposes.

## Key Features

- Display list of stackoverflow user by their reputation.
- Infinite scroll to see all user.
- Bookmark user for quick access.
- Display only bookmarked users.
- Persistent display bookmared user after restart the app.
- See detail of each user.
- Display list of repuation history.
- Infinite scroll to see all reputation history.

## Additional Features and key technical implmentation

- Clean architecture implement by features. Each feature contains data/domain/presentation for clean code and scaling.
- Riverpod as state management in the application.
- Sqlite integrate with Riverpod to store bookmark user. Make bookmark user persistent upon restart.
- User Listview.builder with CachedImageNetwork package for smooth scrolling for long list.
- Custom Hero animation when transition between listview and user detail view. Enhance better experience.
- Service class for api call, using http call and dio package to handle canceled request. Also integrate with Riverpod.
- Stack widget with custom bezier clip to create more curvy UI design.
- Create launcher icons with flutter_launcher_icon package.
- Create spalsh screen with flutter_native_splash package.
- Unit test for simple model class.
- Integration/e2e testing for simple business logic.
