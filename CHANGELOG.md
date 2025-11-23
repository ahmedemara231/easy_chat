# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.1] - 2025-11-23

### Added
- Initial release of Easy Chat package
- Chat interface widget with reverse pagination support
- Customizable message builders for left and right message bubbles
- Built-in message state management (pending, sent, delivered, read)
- Message model with sender information and metadata
- Connectivity monitoring and handling
- Custom error handling and error builders
- Empty state support with custom widgets
- Loading state with custom loading builders
- Performance optimizations with cache extent and item extent options
- Integration with Pagify package for pagination
- Controller methods for chat navigation (moveToMaxBottom, refresh, loadMore)
- Support for different message types (text, images, videos, audio, PDFs)
- Callbacks for loading, error, success, and connectivity changes
- No connection state handling

### Changed
- Removed socket.io client integration (previously included offline and real-time features)
- Simplified architecture to focus on chat UI and pagination
- Updated message display to show messages in rows
- Refactored to use new Pagify version
- Optimized code structure for better maintainability

### Features
- Display messages in a row format
- Reverse pagination for loading older messages
- Flexible data mapping for any backend API
- Custom message widget builders
- Network connectivity awareness
- Error and empty state handling
- Performance-optimized list rendering

### Technical Details
- Built with Flutter SDK >=1.17.0
- Requires Dart SDK ^3.6.0
- Dependencies:
  - pagify (for pagination handling)
  - connectivity_plus ^6.1.1 (for network monitoring)
  - web_socket_channel ^3.0.3
  - socket_io_client ^3.1.2
  - objectbox ^5.0.2 (for local storage)
  - path_provider ^2.1.5

### Removed
- Real-time socket features (commented out for future versions)
- Offline message queuing (temporarily removed)
- Socket event handling (may be added back in future releases)

## [Unreleased]

### Planned Features
- Re-introduction of socket.io support for real-time messaging
- Offline message support with local caching
- Message sync capabilities
- Read receipts and delivery confirmations
- Typing indicators
- Message search functionality
- Media upload progress tracking
- Message reactions support

---

## Version History

### Development Timeline

**November 2025**
- v0.0.1: Initial public release with core chat UI features

**Earlier Development (2024-2025)**
- Multiple iterations on socket integration
- Offline support implementation and removal
- Pagination system refinement
- UI/UX improvements
- Performance optimizations

---

For more information about upcoming features and development roadmap, please visit the [GitHub repository](https://github.com/ahmedemara231/easy_chat).
