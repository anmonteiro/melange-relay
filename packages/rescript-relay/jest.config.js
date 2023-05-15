module.exports = {
  testEnvironment: 'jsdom',
  bail: true,
  testRegex: '/__tests__/.*-tests.js$',
  roots: ['<rootDir>/tests'],
  setupFilesAfterEnv: [
    '<rootDir>/tests/rescript-relay/packages/rescript-relay/__tests__/jestSetup.js',
  ],
};
