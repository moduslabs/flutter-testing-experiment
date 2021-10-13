abstract class Crud<E, K> {
  Future<E> save(E entity);
  Future<E> update(E entity);
  Future<void> remove(E entity);
  Future<E> getOne(K key);
  Future<List<E>> getAll();
}
