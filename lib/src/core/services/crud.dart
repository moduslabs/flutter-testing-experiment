abstract class Crud<E, K> {
  Future<E> save(E entity);
  Future<E> update(E entity);
  Future<void> remove(K id);
  Future<E?> getOne(K id);
  Future<List<E>> getAll();
}
