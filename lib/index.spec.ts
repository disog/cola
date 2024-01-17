import { expect, describe, it } from 'vitest'
import createModule from '.'

describe('wasm', async () => {
  const module = await createModule();

  it('constructs a point', () => {
    const point = new module.Point(1, 2);
    expect(point).toMatchObject({ x: 1, y: 2 });
  });
});