# Wikimon

Find the evolution chain of each Pokemon type on this app!

## Tech stack

- SwiftUI for layout
- MVVM for arcthiteture

### Motivations

I prefered to not use any dependency because I wanted to implement all the networking layer from scratch - if I would have decided to use a 3rd-party library I would still have to implement some adapter layer to use the the networking layer in the way I wanted to.

### Code organization

The code has the following structure:

- Components: Reusable components
- Core: Networking layer (can be extracted for another package) and helper classes
- Models
- Scenes: each screen has a scene that contains a View, ViewModel and can contain other view components, Service and Route classes, specific helpers
- Support: support files - can be changed at any time
    - The idea of KeyConfig is to serve as a base file for all configs in the app (API keys, URLs, public keys, etc) - but they can be served on CI after some configuration and injection on the build process